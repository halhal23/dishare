<template>
  <el-main class="top_main" style="height: 100vh;">
      <el-row class="searchInput" style="background: rgba(255,255,255,0);">
        <el-col :span="14" :xs="24">
          <el-input placeholder="検索キーワード" v-model="keyword"></el-input>
        </el-col>
        <el-col :span="8" :xs="16">
          <el-select v-model="select" placeholder="近くの店を探す" class="select" style="width: 100%;background: #F5F7FA;">
            <el-option label="近くの店を探す" value="1"></el-option>
            <el-option label="人気店を探す" value="2"></el-option>
          </el-select>
        </el-col>
        <el-col :span="2" :xs="8">
          <el-button icon="el-icon-search" style="width: 100%;"></el-button>
        </el-col>
      </el-row>
  </el-main>
</template>

<script>
export default {
  data(){
    return {
      keyword: '',
      select: ''
    }
  }
}
// #F5F7FA
</script>
<style>
.top_main {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}
.el-row.searchInput {
  width: 700px;
  box-shadow: 0 0 20px #ccc;
}

button.el-button,
.select .el-input__inner {
  background: #F5F7FA;
}

@media (min-width: 0px) and (max-width: 768px) {
  .el-row.searchInput {
    width: 100%;
  }
}
</style>