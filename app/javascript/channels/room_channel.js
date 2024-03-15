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
// ここで配信するチャンネルを作成してチャンネルにquestionIdを持たせ、購読しているクライアントに配信している
  const appRoom = consumer.subscriptions.create({channel:"RoomChannel", question_id: questionId},{
// ここからはcreateのコールバック関数
  received(data) {
    console.log("レシーブ")
    const messages = document.getElementById("messages");
    messages.insertAdjacentHTML('beforeend', data['body']);

  setTimeout(function() {
    window.scrollTo(0, document.body.scrollHeight);
    const messages = document.getElementById("messages");
    if (messages !== null){
    messages.scrollTop = messages.scrollHeight;
    } else {
      console.log('Error: No swiper container found.');
      }
    }, 100);
  },
  //received終わり

  speak: function(message) {
    console.log('speakが呼ばれました')
    this.perform("speak", { message: message });
  }
});
 //createメソッド終わり


if (appRoom) {
  console.log('Roomを新しく作ったよ');
}

const input = document.getElementById('post_input');

if(input) {
  input.addEventListener("keypress", function(e) {
    if (e.key=== 'Enter') {
      appRoom.speak(e.target.value);
      e.target.value = '';
      e.preventDefault();
    }
  });
} else {
  console.error("Could not find element with id 'post_input'");
}


document.addEventListener("turbo:before-visit", () => {
  const tag = document.getElementById('messages');
  if ( appRoom !== null && tag !== null ) {
      consumer.subscriptions.remove(appRoom);
    console.log('Roomを消したよ1')
  };
});

history.replaceState(null, null, null);
window.addEventListener('popstate', function(e) {
  const tag = document.getElementById('messages');
  if ( appRoom !== null && tag !== null ) {
    consumer.subscriptions.remove(appRoom);
  console.log('Roomを消したよ2')
};
});
})
// turboのイベントリスナー終わり

