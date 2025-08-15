// Importa a biblioteca prom-client, responsável por expor métricas para o Prometheus
const promClient = require("prom-client");

// Cria um registrador de métricas (Registry) para organizar e registrar todas as métricas da aplicação
const register = new promClient.Registry();

// Define um rótulo padrão (label) para todas as métricas com o nome do aplicativo
register.setDefaultLabels({ app: "server" });

// Configura a coleta automática de métricas padrão do Node.js (CPU, memória, etc.)
promClient.collectDefaultMetrics({ register });


// -------------------- MÉTRICA 1: CONTADOR DE REQUISIÇÕES HTTP --------------------
// Cria uma métrica do tipo Counter para contar o número total de requisições HTTP recebidas
const httpRequestCount = new promClient.Counter({
  name: "http_requests_total", // Nome da métrica que será exposta no Prometheus
  help: "Total HTTP requests", // Descrição da métrica
  labelNames: ["method", "route", "status_code"], // Labels para diferenciar por método, rota e status HTTP
});
// Registra essa métrica no Registry
register.registerMetric(httpRequestCount);


// -------------------- MÉTRICA 2: DURAÇÃO DAS REQUISIÇÕES HTTP --------------------
// Cria uma métrica do tipo Histogram para medir a duração das requisições HTTP em segundos
const httpRequestDuration = new promClient.Histogram({
  name: "http_request_duration_seconds", // Nome da métrica
  help: "HTTP request durations in seconds", // Descrição
  labelNames: ["method", "route", "status_code"], // Labels
  buckets: [0.1, 0.5, 1, 2, 5], // Faixas de tempo para categorizar a duração das requisições
});
// Registra essa métrica no Registry
register.registerMetric(httpRequestDuration);


// -------------------- MIDDLEWARE PARA COLETAR MÉTRICAS --------------------
function metricsMiddleware(req, res, next) {
  // Inicia o temporizador para medir a duração da requisição
  const end = httpRequestDuration.startTimer();

  // Quando a resposta for finalizada...
  res.on("finish", () => {
    // Incrementa o contador de requisições HTTP
    httpRequestCount
      .labels(req.method, req.route?.path || req.path, res.statusCode)
      .inc();

    // Finaliza o temporizador e registra a duração
    end({
      method: req.method,
      route: req.route?.path || req.path,
      status_code: res.statusCode,
    });
  });

  // Continua para o próximo middleware ou rota
  next();
}


// -------------------- ENDPOINT PARA EXPOR AS MÉTRICAS --------------------
function metricsEndpoint(req, res) {
  // Define o tipo de conteúdo da resposta para o formato de métricas do Prometheus
  res.set("Content-Type", register.contentType);

  // Obtém todas as métricas registradas e envia na resposta
  register.metrics().then((metrics) => res.end(metrics));
}


// Exporta o middleware e o endpoint para serem usados na aplicação
module.exports = { metricsMiddleware, metricsEndpoint };
