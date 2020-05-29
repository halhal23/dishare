<template>
  <div class="form-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>ログイン</span>
        <el-button style="float: right; padding: 3px 0" type="text">Operation button</el-button>
      </div>
      <div class="text item">
        <el-form ref="form" label-width="120px">
          <el-form-item label="メールアドレス">
            <el-input v-model="email"></el-input>
          </el-form-item>
          <el-form-item label="パスワード">
            <el-input v-model="password" show-password></el-input>
          </el-form-item>
          <el-form-item>
            <el-button @click="login" style="float: right;" type="success" round>ログイン</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
  </div>
</template>
<script>
export default {
  data () {
    return {
      password: '',
      email: ''
    }
  },
  methods: {
    async login() {
      await this.$auth.loginWith('local', {
        data: {
          email: this.email,
          password: this.password,
          password_confirmation: this.password
        }
      })
        .then( res => {
          console.log('ログイン成功' + ' /pages/login.vue')
          console.log(res)
          return res
        }, err => {
          console.log('ログイン失敗' + ' /pages/login.vue')
          console.log(err)
          return err
        })
    }
  }
}
</script>

<style>
.form-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.el-card {
  width: 400px;
}
</style>>