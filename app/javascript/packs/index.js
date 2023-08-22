$(document).ready(() => {
  const modal_container = document.getElementById('modal-container');
  const modal = document.getElementById('modal');
  const modal_first_part = document.getElementById('first-part');
  const modal_second_part = document.getElementById('second-part');
  const rps_buttons = document.getElementsByClassName('button');
  const local_img_srcs = {};
  const close_btn = document.getElementById('close');
  const users_bet_div = document.getElementById('users_bet');

  // save images sources to display user's choose on modal_container
  function saveImagesSources() {
    for (let i = 0; i < rps_buttons.length; i++) {
      local_img_srcs[rps_buttons[i].getAttribute('value')] = rps_buttons[i].firstElementChild.src;
    }
  }

  function setModalSize(modal, width, height) {
    modal.style.width = width;
    modal.style.height = height;
  }

  function createImgTag(src, id, class_name) {
    const img = document.createElement('img');
    img.src = src;
    img.setAttribute('id', id);
    img.setAttribute('class', class_name);
    return img;
  }

  // add handler on each button
  function handleUserButtonClick(button) {
    modal_container.style.display = 'block';

    const userGuess = button.getAttribute('value');
    const userBetImg = createImgTag(local_img_srcs[userGuess], 'users_bet_img', 'users_bet_img');
    users_bet_div.prepend(userBetImg);

    $.ajax({
      type: 'POST',
      url: 'api/games',
      data: { guess: userGuess },
    }).done((data) => {
      console.log(data.result.message);
      if (getComputedStyle(modal_container).getPropertyValue('display') === 'block') {
        setModalSize(modal,'492px', '591px');
        modal_first_part.style.display = 'none';
        modal_second_part.style.display = 'block';

        const userBetImgElement = document.getElementById('users_bet_img');
        if (userBetImgElement) {
          users_bet_div.removeChild(userBetImgElement);
        }

        const modalTitleSecondPartP = document.getElementById('modal-title-second-part');
        modalTitleSecondPartP.innerText = data.result.message;

        const modalTitleSecondPartBetTextP = document.getElementById('modal-second-part-bet-text');


        let modalTitleSecondPartBetText;
        const resultMessage = data.result.message;

        if (resultMessage === 'You lost!') {
          modalTitleSecondPartBetText = `Curb with ${data.result.computer_guess} wins`;
        } else if (resultMessage === 'You win!') {
          modalTitleSecondPartBetText = `Curb with ${data.result.computer_guess} lost`;
        } else if (resultMessage === 'Tie') {
          modalTitleSecondPartBetText = ``;
        }

        modalTitleSecondPartBetTextP.innerText = modalTitleSecondPartBetText;

        const computerGuessImg = createImgTag(
            local_img_srcs[data.result.computer_guess],
            'computer_guess_img',
            'bet-curb-image'
        );
        modal_second_part.appendChild(computerGuessImg);

        const statisticsCounterDiv = document.getElementById('percentage');
        statisticsCounterDiv.innerText = data.stats.percentage;
      }
    });
  }


  // logic for the close button
  function handleCloseButtonClick() {
    const isFirstPartVisible = getComputedStyle(modal_first_part).getPropertyValue('display') === 'block';

    if (isFirstPartVisible) {
      modal_container.style.display = 'none';
      const usersBetImg = document.getElementById('users_bet_img');
      users_bet_div.removeChild(usersBetImg);

      const computerGuessImg = document.getElementById('computer_guess_img');
      if (computerGuessImg) {
        const secondPartDiv = document.getElementById('second-part');
        secondPartDiv.removeChild(computerGuessImg);
      }
    } else {
      setModalSize(modal, '879px', '492px');

      const computerGuessImg = document.getElementById('computer_guess_img');
      const secondPartDiv = document.getElementById('second-part');
      const modalSecondPartBetText = document.getElementById('modal-second-part-bet-text');
      modalSecondPartBetText.innerText = '';
      if (computerGuessImg) {
        secondPartDiv.removeChild(computerGuessImg);
      }

      modal_container.style.display = 'none';
      modal_first_part.style.display = 'block';
      modal_second_part.style.display = 'none';
    }
  }

  try {
    saveImagesSources();
    for (const button of rps_buttons) {
      button.onclick = () => handleUserButtonClick(button);
    }
    close_btn.onclick = handleCloseButtonClick;
  } catch (error) {
    console.error(error);
  }
});
