function Calculation(){

  const CalculationNum= document.getElementById("item-price");
  const CalculationTax= document.getElementById('add-tax-price');
  const CalculationProfit= document.getElementById('profit');
  
  CalculationNum.addEventListener("keyup", function() {
    const Tax =(CalculationNum.value * 0.1);
    const Profit = (CalculationNum.value - Tax);
    CalculationTax.innerHTML = Tax;
    CalculationProfit.innerHTML = Profit;
  })
  
}

window.addEventListener('load', Calculation)