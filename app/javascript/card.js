document.addEventListener("DOMContentLoaded", function(event) {
  console.log("DOMContentLoaded event fired");
  const pay = () => {
    const payjp = Payjp('pk_test_537bc10b4e9f5e6ea79e3455');
    
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    console.log("Number element:", numberElement);
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    const form = document.getElementById('charge-form')
    form.addEventListener("submit", (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        } else {
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
      });
      e.preventDefault();
    });
  };
  
  pay(); // pay 関数を呼び出す
});

window.addEventListener("turbo:load", pay);