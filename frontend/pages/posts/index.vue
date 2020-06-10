<template>
  <el-main>
    <h2 @click="getPost" style="padding-top: 70px;"></h2>
    <div class="posts_wrapper">
      <div v-for="(post, index) in posts" :key="post.id" class="post_card">
        <el-row class="author" style="padding: 10px; border-bottom: 1px solid #aaa;">
          <el-col :span="12" :xs="24" style="display: flex; align-items: center;">
            <el-avatar :src="post.user.image.url" :size="40" style="margin-right: 30px;"></el-avatar>
            <p style="font-size: 24px; font-weight: bold;">{{ post.user.name }}</p>
          </el-col>
          <el-col :span="12" :xs="24" style="height: 100%;">
            <small style="color: #bbb;">{{ post.created_at }}</small>
          </el-col>
        </el-row>
        <div class="body" style="background: #eec;padding: 10px;">
          <p>{{ post.content }}</p>
        </div>
        <div style="padding: 20px;">
          <div class="shop" style="display: flex; cursor: pointer;border: 1px solid #ccc;" v-popover:popover>
            <el-image style="width: 100px; height: 100px" :src="post.shop_image_url"></el-image>
            <div style="width: 100%;">
              <p style="font-size: 14px;border-bottom: 1px solid #aaa; width: 100%;">{{ post.shop_name }}</p>
              <p>{{ post.shop_access }}</p>
              <el-tag type="warning" size="mini">{{ post.shop_category }}</el-tag>
            </div>
          </div>
          <el-popover
            ref="popover"
            placement="bottom"
            width="350"
            trigger="click">
            <p>{{ post.shop_address }}</p>
            <a :href="post.shop_url" style="padding: 0;" target="_blank">詳しくはこちら</a>
          </el-popover>
        </div>
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
      posts: data,
      visible: false
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
.post_card .shop{
  transition: .4s;
}
.post_card .shop:hover{
  box-shadow: 0 0 20px gray;
}
@media (min-width: 0px) and (max-width: 768px) {
  .post_card {
    width: 95%;
  }
}
</style>