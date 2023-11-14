document.addEventListener('DOMContentLoaded', function() {
  const firstRankSelect = document.getElementById('reservation_rank_first');
  const secondRankSelect = document.getElementById('reservation_rank_second');

  // 第二希望のセレクトボックスの状態を更新する関数
  function updateSecondRankSelect() {
    if (firstRankSelect.value === '') {
      // 第一希望が選択されていない場合は第二希望を選択不可にする
      secondRankSelect.disabled = true;
      secondRankSelect.value = '';
    } else {
      // 第一希望が選択されている場合は第二希望を選択可にする
      secondRankSelect.disabled = false;
    }
  }

  // 第一希望のセレクトボックスが変更されたときに第二希望セレクトボックスの状態を更新
  firstRankSelect.addEventListener('change', updateSecondRankSelect);

  // ページ読み込み時にも第二希望セレクトボックスの状態を更新
  updateSecondRankSelect();
});