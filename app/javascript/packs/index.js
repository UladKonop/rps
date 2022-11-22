$(document).ready(() => {
  try {
    const SECONDS_TO_DISPLAY_MODAL = 1.5
    const modal_container = document.getElementById('modal-container');
    const modal = document.getElementById('modal');
    const modal_first_part = document.getElementById('first-part');
    const modal_second_part = document.getElementById('second-part');
    const rps_buttons = document.getElementsByClassName('button')

    // save images sources to display user's choose on modal_container
    const local_img_srcs = {}
    for (let i = 0; i < rps_buttons.length; i++) {
      local_img_srcs[rps_buttons[i].getAttribute('value')] = rps_buttons[i].firstElementChild.src
    }

    // add handler on each button
    for (let i = 0; i < rps_buttons.length; i++) {
      rps_buttons[i].onclick = function () {
        modal_container.style.display = 'block';

        let img = document.createElement("img");
        img.src = local_img_srcs[rps_buttons[i].getAttribute('value')];
        img.setAttribute('id', 'users_bet_img');
        let users_bet_div = document.getElementById('users_bet');
        users_bet_div.prepend(img)

        setTimeout(function() {
          $.ajax({
            type: 'POST',
            url: 'api/games',
            data: { guess: rps_buttons[i].getAttribute('value') },
          }).done((data) => {

              modal.style.width = "492px";
              modal.style.height = "591px";
              modal_first_part.style.display = "none";
              modal_second_part.style.display = "block";

              let users_bet_div = document.getElementById('users_bet');
              let user_bet_img = document.getElementById('users_bet_img');
              users_bet_div.removeChild(user_bet_img);

          });
        }, (SECONDS_TO_DISPLAY_MODAL * 1000));

      };
    }

    // logic for the close button
    const close_btn = document.getElementById('close');
    close_btn.onclick = function() {
      modal.style.width = "879px";
      modal.style.height = "492px";
      modal_container.style.display = "none";
      modal_first_part.style.display = "block";
      modal_second_part.style.display = "none";
      let users_bet_div = document.getElementById('users_bet');
      let user_bet_img = document.getElementById('users_bet_img');
      users_bet_div.removeChild(user_bet_img);

    }
  } catch (error) {
    console.error(error);
  }
});
