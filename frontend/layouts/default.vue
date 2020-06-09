<template>
    <el-container>
      <Header />
      <sideBar v-if="$store.state.auth.isLoggedIn" />
      <transition name="page"> 
        <nuxt />
      </transition>
    </el-container>
    <!-- 
      z-indexs
      header: 10; 
    -->
</template>

<script>
import Header from '~/components/header.vue'
import sideBar from '~/components/side-bar.vue'

export default {
  components: {
    Header,
    sideBar
  }
}
</script>
