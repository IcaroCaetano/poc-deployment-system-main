/*
supertest → Biblioteca para testar APIs HTTP de forma simples, sem precisar subir o servidor real.
app → A aplicação Express criada em app.js.
*/
/*
supertest → Library for testing HTTP APIs easily, without having to run the real server.
app → The Express application created in app.js.
*/
const request = require("supertest");
const app = require("./app");

/*
Objetivo: Garantir que 5! = 120.
Verificações:
Status HTTP = 200.
Corpo da resposta contém { n: 5, factorial: 120 }
*/
/*
Objective: Ensure that 5! = 120.
Checks:
HTTP status = 200.
Response body contains { n: 5, factorial: 120 }
*/
describe("API /factorial", () => {
  test("GET /factorial/5 returns factorial 120", async () => {
    const res = await request(app).get("/factorial/5");
    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ n: 5, factorial: 120 });
  });

/*
Objetivo: Garantir que números negativos não sejam aceitos.
Verificações:
Status HTTP = 400.
Corpo da resposta possui a propriedade "error"
*/
/*
Objective: Ensure that negative numbers are not accepted.
Checks:
HTTP status = 400.
Response body has the "error" property
*/
  test("GET /factorial/-1 returns error", async () => {
    const res = await request(app).get("/factorial/-1");
    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty("error");
  });


/*
Objetivo: Garantir que entradas não numéricas gerem erro.
Verificações:
Status HTTP = 400.
Corpo da 
resposta contém "error".
*/
/*
Objective: Ensure that non-numeric inputs generate an error.
Checks:
HTTP status = 400.
Response body contains "error".
*/
  test("GET /factorial/abc returns error", async () => {
    const res = await request(app).get("/factorial/abc");
    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty("error");
  });
});

/*
Objetivo: Garantir que o health check responda corretamente.
Verificações:
Status HTTP = 200.
Corpo da resposta (text) é "OK"
*/
/*
Objective: Ensure the health check responds correctly.
Checks:
HTTP status = 200.
Response body (text) is "OK"
*/
describe("API /health-check", () => {
  test("GET /health-check returns OK", async () => {
    const res = await request(app).get("/health-check");
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe("OK");
  });
});
