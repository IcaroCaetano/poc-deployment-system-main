// Função para calcular o fatorial de um número
function factorial(n) {
  // Verifica se o número é negativo e lança um erro caso seja
  if (n < 0) throw new Error("Negative not allowed");

  // Caso base: se n for 0 ou 1, retorna 1
  // Caso recursivo: multiplica n pelo fatorial de (n - 1)
  return n <= 1 ? 1 : n * factorial(n - 1);
}

// Exporta a função para ser utilizada em outros arquivos
module.exports = factorial;
