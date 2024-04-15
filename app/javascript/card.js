// グローバルスコープでpay関数を定義
const pay = () => {
  const payjp = ENV["PAYJP_PUBLIC_KEY"]
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラーメッセージを表示
        alert("カード情報の取得に失敗しました。");
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        document.getElementById("charge-form").submit();
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
    e.preventDefault();
  });
};

document.addEventListener("DOMContentLoaded", function(event) {
  pay(); // pay 関数を呼び出す
});

// Turboリンクスのページロードでもpay関数を再設定
window.addEventListener("turbo:load", pay);