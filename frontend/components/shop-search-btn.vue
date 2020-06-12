<template>
  <el-button @click="getShops" icon="el-icon-search" style="width: 100%;" class="search-icon"></el-button>
</template>

<script>
export default {
  props: { keyword: Object },
  methods: {
    getShops(){
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: 'ラーメン',
        }
      }).then( res => {
        // this.setShops(res.rest)
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `ラーメンの検索結果`,
          position: 'bottom-left',
          duration: 3000
        })
        console.log('searched !!')
        console.log(res)
      }).catch( err => {
        console.log(err)
      })
    }
  }
}
</script>