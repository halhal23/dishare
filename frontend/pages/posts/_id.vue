<template>
  <el-main class="post_show_wrapper">
      <postCard :post="post"/>
      <div class="comments_wrapper">
        <el-timeline>
          <el-timeline-item :timestamp="c.created_at" placement="top" v-for="c in post.comments" :key="c.id">
            <el-card>
              <h4 style="margin-bottom: 20px;">{{ c.message }}</h4>
              <p style="display: flex; align-items: center;">
                <el-avatar style="margin-right: 20px;" :size="30" :src="c.user.image.url"></el-avatar>
                {{ c.user.name }}
              </p>
            </el-card>
          </el-timeline-item>
        </el-timeline>
        <el-input type="textarea" :rows="2"></el-input>
        <el-button type="primary" style="margin-top: 10px;">Comment</el-button>
      </div>
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

<style>
.post_show_wrapper {
  padding-top: 70px;
  display: flex;
  justify-content: space-around;
}
</style>