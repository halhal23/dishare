<template>
  <el-main>
    <h2 @click="getPost" style="padding-top: 70px;"></h2>
    <div class="posts_wrapper">
      <postCard v-for="p in posts" :key="p.id" :post="p" />
    </div>
  </el-main>
</template>

<script>
import postCard from '~/components/post-card.vue'
export default {
  async asyncData( app ){
    let data;
    if (process.client){
      data =  await app.$axios.$get(process.env.browserBaseUrl + '/api/posts')
      console.log('asyncData client side')
      console.log(data)
    } else {
      data =  await app.$axios.$get(process.env.apiBaseUrl + '/api/posts')
      console.log('asyncData server side')
      console.log(data)
    }
    return {
      posts: data,
      visible: false
    }
  },
  methods: {
    getPost(){
      console.log('getPost')
      this.$axios.$get(process.env.apiBaseUrl + '/api/posts').then(res => {
        console.log(res)
      }).catch(err => {
        console.log(err)
      })
    },
    redirectPost(id){
      this.$router.push(`/posts/${id}`)
    }
  },
  components: {
    postCard
  }
}
</script>

<style>
.posts_wrapper {
  display: flex;
  justify-content: space-around;
  align-items: flex-start;
  flex-wrap: wrap;
}

.post_card {
  box-shadow: 0 0 20px gray;
  width: 500px;
  margin: 20px;
  flex-shrink: 0;
}
.post_card .el-col {
  height: 100%;
}
@media (min-width: 0px) and (max-width: 768px) {
  .post_card {
    width: 95%;
  }
}
</style>