<template>
    <el-container>
      <Header />
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
import TheHeader from '~/components/TheHeader.vue'
import Header from '~/components/header.vue'

export default {
  components: {
    TheHeader,
    Header
  }
}
</script>
