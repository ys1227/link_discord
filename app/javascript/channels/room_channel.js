import consumer from "./consumer"

function scrollToBottom() {
  const messages = document.getElementById("messages");
  messages.scrollTop = messages.scrollHeight;
}

function confirm_message() {
  if (messages === nil) {
    console.log('変数はありません')
  };
}

history.replaceState(null, null, null);
window.addEventListener('popstate', function(e) {
  if (appRoom === nil) {
    console.log('変数はありません')
  };
});

document.addEventListener("turbo:load", () => {
  confirm_message;
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
    console.log('speakが呼ばれました')
    this.perform("speak", { message: message });
  }
});

window.addEventListener("keyup", 
  event => {
  const messages = document.getElementById("messages");
  if (event.key === 'Enter') {
    if (messages === null) {
      consumer.subscriptions.remove(appRoom);
      return;
    }
    console.log("呼び出されたよ")
    appRoom.speak(event.target.value); // メッセージを送信
    event.target.value = '';
    scrollToBottom(); // テキストボックスをクリア
    event.preventDefault(); // デフォルトのキー操作を抑制
  }
});

window.addEventListener("beforeunload", () => {
  consumer.subscriptions.remove(appRoom);
  
});

document.addEventListener("turbo:before-visit", () => {
  consumer.subscriptions.remove(appRoom);
});


})

