function trueVhCalc() {
  window.requestAnimationFrame(() => {
    const vh = window.innerHeight * 0.01;
    document.documentElement.style.setProperty("--vh", `${vh}px`);
  });
}

function goTrueVhCalc(i, height0) {
  if (window.innerHeight !== height0 || i >= 120) {
    trueVhCalc();
  } else {
    window.requestAnimationFrame(() => {
      goTrueVhCalc(i + 1, height0);
    });
  }
}

export const vhCalc = () => {
  trueVhCalc();
  let trueVhCalcTick;
  window.addEventListener("orientationchange", () => {
    goTrueVhCalc(0, window.innerHeight);
  });
  window.addEventListener("resize", () => {
    window.cancelAnimationFrame(trueVhCalcTick);
    trueVhCalcTick = window.requestAnimationFrame(trueVhCalc);
  });
};
