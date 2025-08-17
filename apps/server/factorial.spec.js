const factorial = require("./factorial");

/*
Purpose: Verifies that both 0! and 1! return 1.
Expected Behavior:
factorial(0) → 1
factorial(1) → 1
*/
test("factorial of 0 and 1 is 1", () => {
  expect(factorial(0)).toBe(1);
  expect(factorial(1)).toBe(1);
});

/*
Purpose: Confirms that the recursive calculation is correct for a typical positive integer.
Expected Behavior:
factorial(5) → 120
*/
test("factorial of 5 is 120", () => {
  expect(factorial(5)).toBe(120);
});

/*
Purpose: Ensures that the function handles invalid inputs correctly.
Expected Behavior:
Passing a negative number should throw an error with the message:
"Negative not allowed"
*/
test("factorial negative throws", () => {
  expect(() => factorial(-1)).toThrow("Negative not allowed");
});
