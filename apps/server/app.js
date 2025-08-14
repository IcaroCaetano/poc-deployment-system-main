/*Monitoramento de métricas

  Health Check

  Cálculo de fatoriais

  Exposição de métricas para Prometheus
*/

/*
express → Framework Node.js para criar a API.

factorial → Função personalizada que calcula fatoriais (arquivo local factorial.js).

metricsMiddleware / metricsEndpoint → Funções que expõem e coletam métricas da aplicação para monitoramento..
*/
const express = require("express");
const factorial = require("./factorial");
const { metricsMiddleware, metricsEndpoint } = require("./metricsMiddleware");

/*
Cria a instância app do Express.

Aplica o middleware de métricas (metricsMiddleware) a todas as requisições,
permitindo registrar tempos de resposta, contadores, etc.
*/
const app = express();
app.use(metricsMiddleware);

/*
Verifica se o serviço está funcionando.
Sempre retorna HTTP 200 OK com a mensagem "OK".
Útil para Kubernetes liveness e readiness probes.
*/
app.get("/health-check", (req, res) => res.status(200).send("OK"));


/*
Recebe um número n via URL (/factorial/5).
Valida se n é realmente um número.
Usa a função factorial() para calcular o valor.
Retorna o resultado no formato:
*/
app.get("/factorial/:n", (req, res) => {
  const n = parseInt(req.params.n, 10);
  if (isNaN(n)) {
    return res.status(400).json({ error: "Invalid number" });
  }
  try {
    const result = factorial(n);
    res.json({ n, factorial: result });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

/*
Retorna as métricas coletadas pelo metricsMiddleware.

Geralmente no formato Prometheus exposition format, pronto para ser coletado por sistemas como Prometheus e Grafana.
*/
app.get("/metrics", metricsEndpoint);

module.exports = app;
