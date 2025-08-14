/*
supertest → Biblioteca para testar APIs HTTP de forma simples, sem precisar subir o servidor real.
app → A aplicação Express criada em app.js.
*/

const request = require("supertest");
const app = require("./app");

/*
});
Objetivo: Garantir que 5! = 120.
Verificações:
Status HTTP = 200.
Corpo da resposta contém { n: 5, factorial: 120 }
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
  test("GET /factorial/-1 returns error", async () => {
    const res = await request(app).get("/factorial/-1");
    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty("error");
  });


/*
Objetivo: Garantir que entradas não numéricas gerem erro.
Verificações:
Status HTTP = 400.
Corpo da resposta contém "error".
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
describe("API /health-check", () => {
  test("GET /health-check returns OK", async () => {
    const res = await request(app).get("/health-check");
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe("OK");
  });
});
