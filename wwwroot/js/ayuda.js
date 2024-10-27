document.querySelectorAll('.expandable-btn').forEach(button => {
    button.addEventListener('click', () => {
        const content = button.nextElementSibling;
        const arrow = button.querySelector('.arrow');


        if (content.classList.contains('active')) {
            content.classList.remove('active');
            arrow.style.transform = 'rotate(0deg)';
        } else {
            document.querySelectorAll('.content').forEach(c => c.classList.remove('active'));
            document.querySelectorAll('.arrow').forEach(a => a.style.transform = 'rotate(0deg)');

            content.classList.add('active');
            arrow.style.transform = 'rotate(90deg)';
        }
    });
});
