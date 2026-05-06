const timeNode = document.querySelector('.site-time');

if (timeNode) {
  const formatter = new Intl.DateTimeFormat('en-IN', {
    timeZone: 'Asia/Kolkata',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: false,
  });

  const renderTime = () => {
    timeNode.textContent = `IST ${formatter.format(new Date())}`;
  };

  renderTime();
  setInterval(renderTime, 1000);
}