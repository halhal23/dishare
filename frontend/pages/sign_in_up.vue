<template>
  <el-main class="main_form">
    <el-row class="form_content">
      <el-col :xs="24" :span="12" class="left_form both">
        <h3>Login</h3>
        <el-form label-width="120px">
          <el-form-item label="NAME">
            <el-input v-model="name" placeholder="name"></el-input>
          </el-form-item>
          <el-form-item label="NAME">
            <el-input v-model="name" placeholder="name"></el-input>
          </el-form-item>
        </el-form>
      </el-col>
      <el-col :xs="0" :span="12" class="right_form both"></el-col>
    </el-row>
  </el-main>
</template>

<style>
.el-main.main_form {
  background: #ccc;
  display: flex;
  justify-content: center;
  align-content: center;
  height: 100vh;
  padding: 80px 50px;
  background: linear-gradient(200deg, rgb(235, 222, 198), rgb(230, 155, 106)); 
}
.el-row.form_content {
  width: 100%;
}
.el-col.both {
  height: 100%;
}
/* 
.el-col.left_form {
  background: #eee;
}
.el-col.left_form .el-input{
  padding: 0 30px;
}
.el-col.right_form {
  background: #ddd;
}

.el-form {
  background: #fcb;
}

@media (min-width: 0px) and (max-width: 1000px) {
  .el-main.main_form {
    padding: 60px 0;
  }
} */
</style>

<script>
export default {
  data(){
    return {
      name: ''
    }
  }
}
</script>