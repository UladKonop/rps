$(document).ready(() => {
  try {
    const modal = document.getElementById('modal');
    const rps_buttons = document.getElementsByClassName('button');

    const local_img_srcs = {}

    for (let i = 0; i < rps_buttons.length; i++) {
      local_img_srcs[rps_buttons[i].getAttribute('value')] = rps_buttons[i].firstElementChild.src
    }

    for (let i = 0; i < rps_buttons.length; i++) {
      rps_buttons[i].onclick = function () {
        modal.style.display = 'block';

        let img = document.createElement("img");
        img.src = local_img_srcs[rps_buttons[i].getAttribute('value')];
        let users_bet_div = document.getElementById('users_bet');
        users_bet_div.prepend(img);

        // $.ajax({
        //   type: 'POST',
        //   url: 'api/games',
        //   data: { guess: rps_buttons[i].getAttribute('value') },
        // }).done((data) => {
        //
        // });
      };
    }
  } catch (error) {
    console.error(error);
  }
});
