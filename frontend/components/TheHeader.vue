<template>
  <header>
    <ul>
      <li>
        <nuxt-link to="/">ホーム</nuxt-link>
      </li>
      <li>
        <nuxt-link to="/">このサイトについて</nuxt-link>
      </li>
      <li>
        <img src="images/text-logo.png" height="70px" width="210px">
      </li>
      <li>
        <nuxt-link to="/">ログイン</nuxt-link>
      </li>
      <li>
        <nuxt-link to="/">新規登録</nuxt-link>
      </li>
    </ul>
  </header>
</template>

<script>
export default {
  
}
</script>

<style scoped>
header {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 2;
}

ul {
  display: flex;
  justify-content: space-around;
}

li {
  text-decoration: none;
  list-style: none;
}

a {
  line-height: 70px;
  text-decoration: none;
  color: black;
}
</style>