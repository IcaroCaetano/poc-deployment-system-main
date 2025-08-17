// express → framework para criar a API HTTP
// express → framework to create the HTTP API
const express = require("express");
// factorial → módulo interno responsável por calcular o fatorial
// factorial → internal module responsible for calculating the factorial
const factorial = require("./factorial");
// metricsMiddleware → middleware que coleta métricas de requisições
// metricsEndpoint → endpoint que retorna as métricas coletadas
// metricsMiddleware → middleware that collects request metrics
// metricsEndpoint → endpoint that returns the collected metrics
const { metricsMiddleware, metricsEndpoint } = require("./metricsMiddleware");

// Cria uma nova aplicação Express.
// Essa instância (app) é a base do servidor web, onde você define rotas (app.get, app.post, etc.), middlewares e configurações.
// Creates a new Express application.
// This instance (app) is the base of the web server, where you define routes (app.get, app.post, etc.), middleware, and configurations.
const app = express();

// Registra o middleware metricsMiddleware para todas as requisições que chegam ao aplicativo.
// Um middleware no Express é uma função que recebe (req, res, next)
// Registers the metricsMiddleware middleware for all requests that reach the application.
// A middleware in Express is a function that receives (req, res, next)
app.use(metricsMiddleware);

// Esse endpoint é um health check. Ele é usado normalmente por ferramentas de monitoramento, 
// orquestradores (Kubernetes, Docker, etc.) ou load balancers para verificar se a aplicação está rodando e respondendo corretamente.
// This endpoint is a health check. It's typically used by monitoring tools, 
// orchestrators (Kubernetes, Docker, etc.), or load balancers to verify that the application is running and responding correctly.
app.get("/health", (req, res) => res.status(200).send("OK"));

// Quando alguém acessar GET /factorial/5, por exemplo, o valor 5 será capturado como parâmetro :n.
// When someone accesses GET /factorial/5, for example, the value 5 will be captured as the :n parameter.
app.get("/factorial/:n", (req, res) => {
//req.params.n pega o valor da URL como string.
// parseInt(req.params.n, 10) converte para número inteiro na base decimal.
//req.params.n gets the URL value as a string.
// parseInt(req.params.n, 10) converts it to an integer in decimal.
  const n = parseInt(req.params.n, 10);
  // Se o valor não for um número (isNaN(n)), responde com HTTP 400 (Bad Request) e JSON { error: "Invalid number" }.
  // If the value is not a number (isNaN(n)), responds with HTTP 400 (Bad Request) and JSON { error: "Invalid number" }.
  if (isNaN(n)) {
    return res.status(400).json({ error: "Invalid number" });
  }
  try {
    //Se for válido, executa factorial(n), que deve ser uma função definida em algum lugar do código que calcula o fatorial.
    //If valid, execute factorial(n), which must be a function defined somewhere in the code that calculates the factorial.
    const result = factorial(n);
    // Retorna um JSON com o número e o fatorial, por exemplo:
    // { "n": 5, "factorial": 120 }
    // Returns a JSON with the number and factorial, for example:
    // { "n": 5, "factorial": 120 }
    res.json({ n, factorial: result });
  } catch (err) {
    //Caso a função fatorial dispare erro retorna 400
    // If the factorial function triggers an error, it returns 400
    res.status(400).json({ error: err.message });
  }
});
// Expõe o endpoint "/metrics"
// Exposes the "/metrics" endpoint
app.get("/metrics", metricsEndpoint);

// Exports the Express app instance so it can be imported and used in other files
// Exporta a instância do aplicativo Express para que ela possa ser importada e usada em outros arquivos
module.exports = app;
