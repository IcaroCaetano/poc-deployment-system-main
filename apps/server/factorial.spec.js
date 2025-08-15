// Importa a função factorial que será testada
const factorial = require("./factorial");


// -------------------- TESTE 1: Fatorial de 0 e 1 --------------------
// Verifica se o fatorial de 0 e 1 retorna corretamente 1
test("factorial of 0 and 1 is 1", () => {
  expect(factorial(0)).toBe(1); // Fatorial de 0 deve ser 1
  expect(factorial(1)).toBe(1); // Fatorial de 1 deve ser 1
});


// -------------------- TESTE 2: Fatorial de 5 --------------------
// Verifica se o fatorial de 5 retorna corretamente 120
test("factorial of 5 is 120", () => {
  expect(factorial(5)).toBe(120); // 5! = 5 × 4 × 3 × 2 × 1 = 120
});


// -------------------- TESTE 3: Fatorial de número negativo --------------------
// Verifica se a função lança um erro ao tentar calcular fatorial de número negativo
test("factorial negative throws", () => {
  expect(() => factorial(-1)).toThrow("Negative not allowed");
});
