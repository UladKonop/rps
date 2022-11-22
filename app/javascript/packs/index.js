$(document).ready(() => {
  try {
    const modal_container = document.getElementById('modal-container');
    const modal = document.getElementById('modal');
    const modal_first_part = document.getElementById('first-part');
    const modal_second_part = document.getElementById('second-part');
    const rps_buttons = document.getElementsByClassName('button');
    const local_img_srcs = {};
    const close_btn = document.getElementById('close');
    const users_bet_div = document.getElementById('users_bet');

    // save images sources to display user's choose on modal_container
    function save_images_sources() {
      for (let i = 0; i < rps_buttons.length; i++) {
        local_img_srcs[rps_buttons[i].getAttribute('value')] = rps_buttons[i].firstElementChild.src;
      }
    }

    function set_modal_size(modal, width, height) {
      modal.style.width = width;
      modal.style.height = height;
    }

    function create_img_tag(src, id, class_name) {
      const img = document.createElement('img');
      img.src = src;
      img.setAttribute('id', id);
      img.setAttribute('class', class_name);
      return img;
    }

    // add handler on each button
    function set_user_guess_button_onclick_handler(button) {
      button.onclick = function () {
        modal_container.style.display = 'block';
        users_bet_div.prepend(create_img_tag(local_img_srcs[button.getAttribute('value')], 'users_bet_img', 'users_bet_img'));
        $.ajax({
          type: 'POST',
          url: 'api/games',
          data: { guess: button.getAttribute('value') },
        }).done((data) => {
          if (getComputedStyle(modal_container).getPropertyValue('display') == 'block') {
            set_modal_size(modal, '492px', '591px');

            modal_first_part.style.display = 'none';
            modal_second_part.style.display = 'block';

            const user_bet_img = document.getElementById('users_bet_img');
            if (user_bet_img) {
              users_bet_div.removeChild(user_bet_img);
            }
            const modal_title_second_part_p = document.getElementById('modal-title-second-part');
            modal_title_second_part_p.innerText = data.result.message;
            const modal_title_second_part_bet_text_p = document.getElementById('modal-second-part-bet-text');

            if (data.result.message == 'You lost!') {
              modal_title_second_part_bet_text_p.innerText = `Curb with ${data.result.computer_guess} wins`;
            } else if (data.result.message == 'You win!') {
              modal_title_second_part_bet_text_p.innerText = `Curb with ${data.result.computer_guess} lost`;
            }

            modal_second_part.append(create_img_tag(local_img_srcs[data.result.computer_guess], 'computer_guess_img', 'bet-curb-image'));
          }
        });
      };
    }

    // logic for the close button
    function set_close_button_onclick_handler() {
      close_btn.onclick = function () {
        if (getComputedStyle(modal_first_part).getPropertyValue('display') == 'block') {
          modal_container.style.display = 'none';
          const users_bet_img = document.getElementById('users_bet_img');
          users_bet_div.removeChild(users_bet_img);
          if (typeof (computer_guess_img) !== 'undefined' && computer_guess_img != null) {
            const second_part_div = document.getElementById('second-part');
            second_part_div.removeChild(computer_guess_img);
          }
        } else {
          set_modal_size(modal, '879px', '492px');
          const computer_guess_img = document.getElementById('computer_guess_img');
          const second_part_div = document.getElementById('second-part');
          const modal_second_part_bet_text = document.getElementById('modal-second-part-bet-text');
          modal_second_part_bet_text.innerText = '';
          second_part_div.removeChild(computer_guess_img);
          modal_container.style.display = 'none';
          modal_first_part.style.display = 'block';
          modal_second_part.style.display = 'none';
        }
      };
    }

    save_images_sources();
    for (let i = 0; i < rps_buttons.length; i++) {
      set_user_guess_button_onclick_handler(rps_buttons[i]);
    }
    set_close_button_onclick_handler();
  } catch (error) {
    console.error(error);
  }
});
