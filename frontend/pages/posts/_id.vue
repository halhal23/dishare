<template>
  <el-main class="" style="padding-top: 70px;">
      <postCard :post="post"/>
  </el-main>
</template>

<script>
import postCard from '~/components/post-card.vue'
export default {
  async asyncData(app){
    let data;
    if (process.client){
      data =  await app.$axios.$get(process.env.browserBaseUrl + `/api/posts/${app.params.id}`)
      console.log('asyncData client side')
      console.log(data)
    } else {
      data =  await app.$axios.$get(process.env.apiBaseUrl + `/api/posts/${app.params.id}`)
      console.log('asyncData server side')
      console.log(data)
    }
    return {
      post: data
    }
  },
  components: {
    postCard
  }
}
</script>