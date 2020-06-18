<template> 
  <el-main class="mypage_wrapper" v-if="currentUser">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>My Profile</span>
        <el-button 
          style="float: right; padding: 3px 0;font-size: 15px;color: #E6A23C;" 
          type="text" 
          @click="onModal(true)"
        ><i class="el-icon-edit"></i> EDIT</el-button>
      </div>
      <div class="text item">
        <div>
          <el-avatar :src="currentUser.image.url" :size="100" v-if="currentUser.image"></el-avatar>
          <img src="~/static/images/no-image.png" width="100px" height="100px" v-else>
        </div>
        <h1>{{ currentUser.name }}</h1>
        <h1>{{ currentUser.email }}</h1>
      </div>
    </el-card>

    <userInfoCard :user="user" />

    <userEditForm :userEditFormModal="userEditFormModal" :currentUser="currentUser" @onModal="onModal(false)" />

  </el-main>

</template>

<script>
import userInfoCard from '~/components/user-info-card.vue'
import userEditForm from '~/components/modals/user-edit-form.vue'
import { mapGetters } from 'vuex'
export default {
  data(){
    return {
      userEditFormModal: false,
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    }),
    async user(){
      let baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
      let data = await this.$axios.$get(baseUrl + `/api/users/${this.currentUser.id}`)
      console.log('asyncData')
      console.log(data)
      return {
        user: data
      }
    }
  },
  methods: {
    onModal(bool){
      this.userEditFormModal = bool
    }
  },
  components: {
    userEditForm,
    userInfoCard
  }
}
</script>

<style>
.mypage_wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  padding: 0 10px;
}
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
  text-align: center;
  width: 100%;
  padding: 20px 0;
}

.box-card {
  width: 480px;
}
</style>