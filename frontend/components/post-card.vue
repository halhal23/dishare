<template>
  <el-card class="post-card">
    <div class="author">
      <el-avatar :src="post.user.image.url" :size="40" style="margin-right: 30px;"></el-avatar>
      <p style="font-size: 20px; font-weight: bold;">{{ post.user.name }}</p>
      <!-- <small style="color: #aaa;font-size: 5px;">{{ post.created_at }}</small> -->
    </div>
    <div class="content" style="padding: 5px; background: #ddc;">
      <p style="font-size: 14px; font-weight: bold;">{{ post.content }}</p>
    </div>
    <el-image
      :src="post.shop_image_url"
      style="width: 100%;"
      fit="fill"></el-image>
    <div class="shop_detail" style="padding: 20px;">
      <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_name }}</p>
      <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_category }}</p>
      <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_access }}</p>
      <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_address }}</p>
      <a class="shop_detail_item" :href="post.shop_url" style="padding: 0;" target="_blank">詳しくはこちら</a>
    </div>
    <div class="menu">      
      <el-popover
        placement="bottom"
        width="350"
        trigger="click">
        <el-input v-model="message" type="textarea" :rows="2"></el-input>
        <el-button @click="createComment" type="primary" style="margin-top: 10px;">Comment</el-button>
        <div slot="reference" class="post_icon" style="background: #fca;">
         <i class="el-icon-chat-dot-round" style="font-size: 30px;"></i>
        </div>
      </el-popover>
      <nuxt-link :to="{path: `/posts/${post.id}`}" style="background: #acf;" class="post_icon">
        <i class="el-icon-info" style="font-size: 30px;"></i>
      </nuxt-link>
      <nuxt-link :to="{path: `/users/${post.user.id}`}" style="background: #fac;" class="post_icon">
        <i class="el-icon-user" style="font-size: 30px;"></i>
      </nuxt-link>
      <!-- <p style="margin-left: auto;">コメントを書く</p> -->
    </div>
  </el-card>
</template>

<script>
export default {
  props: {
    post: Object
  },
  data(){
    return {
      message: ''
    }
  },
  methods: {
    createComment() {
      const formData = {
        message: this.message,
        user_id: this.$store.state.auth.currentUser.id,
        post_id: this.post.id
      }
      this.$axios.$post(process.env.browserBaseUrl + `/api/comments`, formData).then(res => {
        console.log('res')
        console.log(res)
        this.$router.push(`/posts/${this.post.id}`)
        this.post = res
      }).catch(err => {
        console.log(err)
      })
    },
  }
}
</script>

<style>
.post-card {
  width: 300px;
  flex-shrink: 0;
  margin-bottom: 20px;
}
.post-card .el-card__body{
  padding: 0;
}
.post-card .author{
  padding: 5px 10px;
  border-bottom: 1px solid #ccc;
  display: flex;
  align-items: center;
}
.shop_detail_item {
  border-bottom: 1px solid #bba;
}
.post-card .menu{
  display: flex;
  align-items: center;
}
.post-card .menu span{
  width: 100%;
  height: 100%;
}
.post_icon {
  text-align: center;
  padding: 15px 0;
}
@media (min-width: 0px) and (max-width: 450px) {
  .post-card {
    width: 95%;
  }
}
</style>