import Head from "next/head";
import styles from "/assets/css/Home.module.css";

import Shader from "../components/shader/shader";
import { vhCalc } from "/assets/js/viewport-calc-height";

import Image from "next/image";
import studioPic from "/assets/img/studio.jpg";
import argos from "/assets/img/argos.png";
import lexus1 from "/assets/img/lexus1.png";
import lexus2 from "/assets/img/lexus2.png";

import { useState, useEffect } from "react";

export default function Home() {
  const [isActive, setActive] = useState(false);
  useEffect(() => {
    vhCalc();
  });
  const toggleClass = (e) => {
    if (window.matchMedia("(min-width: 700px)").matches) return;
    e.preventDefault();
    setActive(!isActive);
  };
  return (
    <div className={styles.container}>
      <Head>
        <title>Décalage productions</title>
        <meta name="description" content="Composition & Sound Design for your Project" />
        <link rel="icon" type="image/x-icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎶</text></svg>" />
      </Head>

      <div className={styles.main}>
        <h1>Décalage</h1>
        <p className={styles.baseline}>Composition &amp; Sound Design for your Project</p>

        <h2 className={styles.nounderline}>Projets</h2>
        <a className={styles.project} target="_blank" rel="noreferrer" href="https://player.vimeo.com/video/538051635">
          <h3>Lexus 2021</h3>
          <p>Soundtrack</p>
        </a>
        <div className={styles.video}>
          <Image src={lexus2} alt="" placeholder="blur" />
        </div>

        <a className={styles.project} target="_blank" rel="noreferrer" href="https://player.vimeo.com/video/572623840">
          <h3>Lexus 2021</h3>
          <p>Soundtrack</p>
        </a>
        <div className={styles.video}>
          <Image src={lexus1} alt="" placeholder="blur" />
        </div>

        <a className={styles.project} target="_blank" rel="noreferrer" href="https://player.vimeo.com/video/568963259">
          <h3>Argos 2021</h3>
          <p>Sound Design &amp; Music Arrangement</p>
        </a>
        <div className={styles.video}>
          <Image src={argos} alt="" placeholder="blur" />
        </div>

        <h2 className={styles.studioTitle}>
          <a href="/studio.jpg" target="_blank" rel="noreferrer" onClick={toggleClass}>
            Studio
          </a>
        </h2>
        <div className={`${styles.studio} ${isActive ? styles.active : ""}`}>
          <a href="/studio.jpg" target="_blank" rel="noreferrer">
            <Image src={studioPic} alt="studio de production son" placeholder="blur" />
          </a>
        </div>

        <h2>
          <a href="mailto:contact@decalageproductions.com">Contact</a>
        </h2>

        <br />
        <br />
        <br />

        <div className={styles.shader}>
          <Shader />
        </div>
      </div>
      {/* <Script src="https://player.vimeo.com/api/player.js" /> */}
    </div>
  );
}
