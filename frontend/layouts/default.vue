<template>
    <el-container>
      <Header />
      <nuxt />
    </el-container>
</template>

<script>
import TheHeader from '~/components/TheHeader.vue'
import Header from '~/components/header.vue'

export default {
  components: {
    TheHeader,
    Header
  }
}
</script>

<style>
.el-container {
  background: #ccc;
  flex-direction: column;
}
</style>
