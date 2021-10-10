import Head from "next/head";
import styles from "../styles/Home.module.css";

import Shader from "../components/shader/shader";

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Décalage production</title>
        <meta name="description" content="here be dragons" />
        <link href="https://fonts.googleapis.com/css2?family=Major+Mono+Display&display=swap" rel="stylesheet" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <div className={styles.main}>
        <h1>
          décAlAge <br /> production
        </h1>
        <p>on crée pendant que vous dormez</p>
        <div className={styles.shader}>
          <Shader />
        </div>
      </div>
    </div>
  );
}
