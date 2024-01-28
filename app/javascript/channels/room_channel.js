import consumer from "./consumer"

function scrollToBottom() {
  const messages = document.getElementById("messages");
  messages.scrollTop = messages.scrollHeight;
}

document.addEventListener("turbo:load", () => {
  const messages = document.querySelector('#messages');
  if (messages === null) {
    return;
  }
  const currentUserId = messages.dataset.currentUserId;
  const questionId = messages.dataset.questionId;
  console.log("notnull")
  scrollToBottom();

// 「const appRoom =」を追記
// ここで配信するチャンネルを作成してチャンネルにquestionIdを持たせ、購読しているクライアントに配信している？
  const appRoom = consumer.subscriptions.create({channel:"RoomChannel", question_id: questionId},{

  received(data) {
    console.log("レシーブ")
    const messages = document.getElementById("messages");
    messages.insertAdjacentHTML('beforeend', data['body']);
    scrollToBottom();
  },

  speak: function(message) {
    console.log(message)
    console.log(currentUserId)
    console.log(questionId)
    this.perform("speak", { message: message });
  }
});

window.addEventListener("keyup", 
  event => {
  if (event.key === 'Enter') {
    console.log("呼び出されたよ")
    appRoom.speak(event.target.value); // メッセージを送信
    event.target.value = '';
    scrollToBottom(); // テキストボックスをクリア
    event.preventDefault(); // デフォルトのキー操作を抑制
  }
});
})

