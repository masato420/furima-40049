window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    const tax = Math.floor(inputValue * 0.1);
    const profit = Math.floor(inputValue - tax);

    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  })
});