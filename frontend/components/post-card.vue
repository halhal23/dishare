<template>
  <el-card class="post-card">
    <div class="images">
      <el-carousel indicator-position="outside" :autoplay="false">
        <el-carousel-item v-if="post.shop_image_url">
          <el-image
          :src="post.shop_image_url"
          style="width: 100%;height: 100%;"
          fit="cover"></el-image>
        </el-carousel-item>
        <el-carousel-item v-for="photo in post.photos" :key="photo.id">
          <!-- <el-image
          v-if="post.shop_image_url"
          :src="post.shop_image_url"
          style="width: 100%;height: 100%;"
          fit="fill"></el-image> -->
          <el-image
          v-if="photo"
          :src="photo.picture.url"
          style="width: 100%;height: 100%;"
          fit="cover"></el-image>
          <el-image
          v-else
          src="images/noimage.png"
          style="width: 100%;height: 100%;"
          fit="fill"></el-image>
        </el-carousel-item>
      </el-carousel>
    </div>
    <div class="contents"> 
      <div class="author">
        <el-avatar :src="post.user.image.url" :size="40"></el-avatar>
        <p style="font-size: 20px; font-weight: bold;margin: 0 30px;">{{ post.user.name }}</p>
        <el-tag type="warning" v-if="post.shop_name">お店紹介</el-tag>
      </div>
      <div class="message" style="margin: 20px 0;">
        <p style="font-size: 14px; font-weight: bold;">{{ post.content }}</p>
      </div>
      <el-popover
        placement="bottom"
        width="350"
        trigger="click">
        <div class="shop_detail" style="padding: 20px;">
          <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_name }}</p>
          <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_category }}</p>
          <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_access }}</p>
          <p class="shop_detail_item" style="font-size: 14px; font-weight: bold;">{{ post.shop_address }}</p>
          <a class="shop_detail_item" :href="post.shop_url" style="padding: 0;" target="_blank">詳しくはこちら</a>
        </div>
        <el-button v-if="post.shop_name" type="warning" size="mini" slot="reference" style="box-shadow: 0 0 8px #aaa;" round>お店の情報表示</el-button>
      </el-popover>

      <div class="menu">      
        <el-popover
          placement="bottom"
          width="350"
          trigger="click">
          <el-input v-model="message" type="textarea" :rows="2"></el-input>
          <el-button @click="createComment" type="primary" style="margin-top: 10px;">Comment</el-button>
          <div slot="reference" class="post_icon comment_icon" style="background: #d2ff08;">
          <i class="el-icon-chat-dot-round" style="font-size: 25px;"></i>
          </div>
        </el-popover>
        <nuxt-link :to="{path: `/posts/${post.id}`}" style="background: #00f7f7;" class="post_icon">
          <i class="el-icon-info" style="font-size: 25px;"></i>
        </nuxt-link>
        <nuxt-link :to="{path: `/users/${post.user.id}`}" style="background: #ff0077;" class="post_icon">
          <i class="el-icon-user" style="font-size: 25px;"></i>
        </nuxt-link>
        <el-button @click="deletePost(post.id)" v-if="$store.state.auth.currentUser.id == post.user.id" type="danger" size="mini" icon="el-icon-delete" circle></el-button>
      </div>
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
    deletePost(id){
      this.$confirm('Are you sure you want to delete it?', 'DELETE', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning',
        center: true
      }).then(() => { 
        this.$axios.$delete(process.env.browserBaseUrl + `/api/posts/${id}`).then(res => {
          console.log('delete')
          this.$emit('getUpdatePosts')
        })
       }).catch(() => {})
    }
  }
}
</script>

<style>
.post-card {
  width: 500px;
  flex-shrink: 0;
  margin-bottom: 20px;
  /* height: 250px; */
}
.post-card .el-card__body{
  padding: 15px 15px 0 15px;
  display: flex;
}
.post-card .images {
  width: 40%;
}
.post-card .el-carousel__container {
  height: 200px;
}
.post-card .contents {
  width: 60%;
  background: #ffffff;
  padding-left: 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.post-card .author {
  display: flex;
  /* justify-content: center; */
  align-items: center;
}
.post-card .menu {
  display: flex;
  align-items: center;
}
.post-card .menu .post_icon {
  width: 50px;
  height: 50px;
  padding: 0;
  border-radius: 25px;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0 30px 15px 0;
  box-shadow: 0 0 8px #aaa;
  flex-shrink: 0;
}
.shop_detail_item {
  border-bottom: 1px solid #bba;
  margin: 10px 0;
}
@media (min-width: 0px) and (max-width: 450px) {
  .post-card {
    width: 95%;
  }
  .post-card .el-card__body{
    display: flex;
    flex-direction: column-reverse;
  }
  .post-card .images {
    width: 80%;
    margin: 0 auto;
  }
  .post-card .contents {
    width: 100%;
    align-items: center;
    padding-right: 15px;
  }
  .post-card .menu {
    justify-content: space-around;
    width: 100%;
  }
  .post-card .menu .post_icon {
    margin: 15px 0;
  }
}
</style>