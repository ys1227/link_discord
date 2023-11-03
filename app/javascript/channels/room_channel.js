import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const messages = document.querySelector('#messages');
  if (messages === null) {
    return;
  }
  const currentUserId = messages.dataset.currentUserId;
  const questionId = messages.dataset.questionId;
  console.log("notnull")

// 「const appRoom =」を追記
// ここで配信するチャンネルを作成してチャンネルにquestionIdを持たせ、購読しているクライアントに配信している？
  const appRoom = consumer.subscriptions.create({channel:"RoomChannel", question_id: questionId},{

  received(data) {
    console.log("accepted")
    console.log(data)
    const messages = document.getElementById("messages");
    messages.insertAdjacentHTML('beforeend', data['body']);
  },

  speak: function(message) {
    console.log(message)
    console.log(currentUserId)
    console.log(questionId)
    return this.perform('speak', {message: message, question_id: questionId});
  }
});

window.addEventListener("keypress", function(e) {
  if (e.keyCode === 13) {
    appRoom.speak(e.target.value); // メッセージを送信
    e.target.value = ''; // テキストボックスをクリア
    e.preventDefault(); // デフォルトのキー操作を抑制
  }
});
})
