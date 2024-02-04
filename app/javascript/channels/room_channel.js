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
// ここからはcreateのコールバック関数
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
 //createメソッド終わり

if (appRoom) {
  console.log('Roomを新しく作ったよ');
}


window.addEventListener("keyup", 
  event => {
  const messages = document.getElementById("messages");
  if (event.key === 'Enter') {
    if (messages === null) {
      return;
    }
    console.log("enter")
    event.preventDefault(); // デフォルトのキー操作を抑制
    appRoom.speak(event.target.value); // メッセージを送信
    event.target.value = '';
    scrollToBottom(); // テキストボックスをクリア
  }
});

window.addEventListener("beforeunload", () => {
  consumer.subscriptions.remove(appRoom);
  console.log('Roomを消したよ1')
});

document.addEventListener("turbo:before-visit", () => {
  consumer.subscriptions.remove(appRoom);
  console.log('Roomを消したよturbo')
});

history.replaceState(null, null, null);
window.addEventListener('popstate', function(e) {
  consumer.subscriptions.remove(appRoom);
  console.log('Roomを消したよ3')
});

})
// turboのイベントリスナー終わり

