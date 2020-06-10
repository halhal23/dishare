<template>
  <el-main>
    <h2 @click="getPost" style="padding-top: 70px;">posts</h2>
    <div class="posts_wrapper">
      <div v-for="post in posts" :key="post.id" class="post_card">
        <h3>{{ post.title }}</h3>
        <h3>{{ post.content }}</h3>
        <h3>{{ post.shop_name }}</h3>
        <h3>{{ post.shop_address }}</h3>
        <h3>{{ post.shop_access }}</h3>
        <a :href="post.shop_url">{{ post.shop_url }}</a>
        <h3>{{ post.shop_image_url }}</h3>
        <p>{{ post }}</p>
      </div>
    </div>
  </el-main>
</template>

<script>
export default {
  async asyncData( app ){
    const data =  await app.$axios.$get(process.env.apiBaseUrl + '/api/posts')
    console.log('asyncData')
    console.log(data)
    return {
      posts: data
    }
  },
  methods: {
    getPost(){
      console.log('getPost')
      this.$axios.$get(process.env.browserBaseUrl + '/api/posts').then(res => {
        console.log(res)
      }).catch(err => {
        console.log(err)
      })
    }
  }
}
</script>

<style>
.posts_wrapper {
  display: flex;
  justify-content: center;
  align-items: flex-start;
}

.post_card {
  box-shadow: 0 0 20px gray;
  width: 500px;
}
</style>