<template>
  <el-main class="mypage_wrapper" v-if="currentUser">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>{{ currentUser.name }}</span>
        <el-button 
          style="float: right; padding: 3px 0" 
          type="text" 
          @click="onModal(true)"
        >EDIT</el-button>
      </div>
      <div class="text item">
        <h1>{{ currentUser.email }}</h1>
      </div>
    </el-card>
    <userEditForm :userEditFormModal="userEditFormModal" :currentUser="currentUser" @onModal="onModal(false)" />
  </el-main>
</template>

<script>
import userEditForm from '~/components/modals/user-edit-form.vue'
import { mapGetters } from 'vuex'
export default {
  data(){
    return {
      userEditFormModal: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    })
  },
  methods: {
    onModal(bool){
      this.userEditFormModal = bool
    }
  },
  components: {
    userEditForm
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
}

.box-card {
  width: 480px;
}
</style>