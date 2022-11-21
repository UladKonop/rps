$(document).ready(() => {
  try {
    const modal = document.getElementById('modal');
    const rps_buttons = document.getElementsByClassName('button');

    for (let i = 0; i < rps_buttons.length; i++) {
      rps_buttons[i].onclick = function () {
        modal.style.display = 'block';

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
