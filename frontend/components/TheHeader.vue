<template>
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
</template>

<script>
export default {
  
}
</script>

<style scoped>
ul {
  display: flex;
  justify-content: space-around;
  padding: 0;
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