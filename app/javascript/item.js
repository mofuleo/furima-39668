
window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const target1 = document.getElementById("add-tax-price");
  const target2 = document.getElementById("profit");

   priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const fee = Math.floor(inputValue * 0.1);
    const profit = inputValue - fee;
    
    target1.innerHTML = fee;
    target2.innerHTML = profit;

  });
});

