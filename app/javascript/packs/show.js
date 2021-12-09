window.onload = function() {
  const change_color_cols = document.querySelectorAll('.change-color');
  const mypage_message = document.getElementById("flash-message").textContent;
  const regex = new RegExp('本日お菓子を食べたことを申告されました*');
  if (regex.test(mypage_message)){ 
    change_color_cols.forEach(function (change_color_col) {
    change_color_col.style.color = 'red';
    })
  }
}
