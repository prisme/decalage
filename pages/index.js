import Head from "next/head";
import classNames from "classnames/bind";
import styles from "../assets/css/Home.module.css";

import Shader from "../components/shader/shader";
import { vhCalc } from "../assets/js/viewport-calc-height";

import { NextSeo } from "next-seo";
import Plyr from "plyr-react";
import "plyr-react/dist/plyr.css";
import Close from "../assets/img/close.svg";

import Image from "next/image";
import studioPic from "../assets/img/studio.jpg";
import argos from "../assets/img/argos.png";
import lexus1 from "../assets/img/lexus1.png";
import lexus2 from "../assets/img/lexus2.png";
import reset from "../assets/img/reset.png";

import { useState, useEffect, useCallback } from "react";

let cx = classNames.bind(styles);

export default function Home() {
  const [isStudioActive, setStudioActive] = useState(false);
  const [playerId, setPlayerId] = useState(null);

  const escFunction = useCallback((event) => {
    const { keyCode } = event;
    if (keyCode === 27) {
      setPlayerId(null);
    }
  }, []);
  useEffect(() => {
    vhCalc();
    window.addEventListener("keydown", escFunction);
    return () => {
      window.removeEventListener("keydown", escFunction);
    };
  }, [escFunction]);

  const toggleStudio = (e) => {
    if (window.matchMedia("(min-width: 700px)").matches) return;
    e.preventDefault();
    setStudioActive((isStudioActive) => !isStudioActive);
  };

  const TITLE = "Décalage Productions";
  const DESCRIPTION = "Composition & Sound Design for your Project";
  const URL = "https://www.decalageproductions.com/";

  return (
    <>
      <NextSeo
        title={TITLE}
        description={DESCRIPTION}
        canonical={URL}
        openGraph={{
          type: "website",
          url: URL,
          title: TITLE,
          site_name: TITLE,
          description: DESCRIPTION,
          images: [
            {
              url: `${URL}share.jpg`,
              width: 1280,
              height: 800,
              alt: TITLE,
              type: "image/jpeg",
            },
          ],
        }}
      />
      <Head>
        <title>{TITLE}</title>
        <meta name="description" content={DESCRIPTION} />
        <link rel="icon" type="image/x-icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎶</text></svg>" />
      </Head>

      <div className={styles.main}>
        <h1>Décalage</h1>
        <p className={styles.baseline}>Composition &amp; Sound Design for your Project</p>

        <h2 className={styles.nounderline}>Projects</h2>
        <div
          className={styles.project}
          onClick={() => {
            setPlayerId(760259697);
          }}
        >
          <h3>MMIC Clothes 2022</h3>
          <p>Soundtrack</p>
        </div>
        <div className={styles.video}>
          <Image src={reset} alt="" placeholder="blur" />
        </div>
        <div
          className={styles.project}
          onClick={() => {
            setPlayerId(538051635);
          }}
        >
          <h3>Lexus 2021</h3>
          <p>Soundtrack</p>
        </div>
        <div className={styles.video}>
          <Image src={lexus2} alt="" placeholder="blur" />
        </div>

        <div
          className={styles.project}
          onClick={() => {
            setPlayerId(572623840);
          }}
        >
          <h3>Lexus 2021</h3>
          <p>Soundtrack</p>
        </div>
        <div className={styles.video}>
          <Image src={lexus1} alt="" placeholder="blur" />
        </div>

        <div
          className={styles.project}
          onClick={() => {
            setPlayerId(568963259);
          }}
        >
          <h3>Argos 2021</h3>
          <p>Sound Design &amp; Music Arrangement</p>
        </div>
        <div className={styles.video}>
          <Image src={argos} alt="" placeholder="blur" />
        </div>

        <h2 className={styles.studioTitle}>
          <a href="/studio.jpg" target="_blank" rel="noreferrer" onClick={toggleStudio}>
            Studio
          </a>
        </h2>
        <div className={cx("studio", { studioActive: isStudioActive })}>
          <a href="/studio.jpg" target="_blank" rel="noreferrer">
            <Image src={studioPic} alt="studio de production son" placeholder="blur" />
          </a>
        </div>

        <h2>
          <a href="mailto:contact@decalageproductions.com">Contact</a>
        </h2>

        <div className={styles.shader}>
          <Shader />
        </div>

        {playerId && (
          <div className={cx("player")}>
            <button className={styles.playerClose}>
              <Close
                onClick={() => {
                  setPlayerId(null);
                }}
              />
            </button>
            <Plyr
              source={{
                type: "video",
                sources: [
                  {
                    src: playerId,
                    provider: "vimeo",
                  },
                ],
              }}
              options={{
                controls: ["play-large", "mute", "fullscreen"],
                fullscreen: { iosNative: true },
                hideControls: false,
                autoplay: true,
              }}
            />
          </div>
        )}
      </div>
    </>
  );
}
