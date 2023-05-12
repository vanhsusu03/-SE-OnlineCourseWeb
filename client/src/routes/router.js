import {createWebHistory, createRouter} from "vue-router";

// import pages and components
import Home from '../pages/Home.vue';
import Login from '../pages/Login.vue';
import Register from '../pages/Register.vue';
import Deposit from '../pages/Deposit.vue';
import Cart from '../pages/Cart.vue';
import StudentInfo from '../pages/StudentInfo.vue';
import CourseList from '../components/CourseList.vue';
import Searching from '../pages/Searching.vue';
import CourseInfo from '../components/CourseInfo.vue';
import CourseDetail from '../components/CourseDetail.vue';
import MyCourses from '../components/MyCourses';
import AboutUs from '../pages/AboutUs';
import BecomeInstructor from '../pages/BecomeInstructor';
import InstructorInfo from '../pages/InstructorInfo.vue';
import StudyPage from '../pages/StudyPage';
import Admin from '../pages/Admin';
// import EditInfo from '../components/EditInfo.vue';
import PurchaseHistory from '../pages/PurchaseHistory.vue';
import InstructorManage from '../pages/InstructorManage';

import store from '@/store/index';

const routes = [
    {  path: "/", name: "Home", component: Home},
    {  path: "/login", name: "Login", component: Login},
    {  path: "/signup", name: "SignUp", component: Register},
    {  path: "/deposit", name: "Deposit", component: Deposit},
    {  path: "/account/info", name: "StudentInfo", component: StudentInfo},
    {  path: "/course/info/:courseId", name: "CourseInfo", component: CourseInfo},
    {  path: "/cart", name: "Cart", component: Cart},
    {  path: "/courses", name: "CourseList", component: CourseList},
    {  path: "/searching/:keyword", name: "Searching", component: Searching},
    {  path: "/mycourses", name: "MyCourse", component: MyCourses},
    {  path: "/aboutus", name: "AboutUs", component: AboutUs},
    {  path: "/become/instructor", name: "BecomeInstructor", component: BecomeInstructor},
    {  path: "/instructor/info/show/:instructorId", name: "InstructorInfox", component: InstructorInfo},
    {  path: "/purchase/history", name: "PurchaseHistory", component: PurchaseHistory},
    {  path: "/instructor/manage", name: "InstructorManage", component: InstructorManage},
    {  path: "/course/detail/:courseId", name: "CourseDetail", component: CourseDetail},
    {  path: "/study/:courseId", name: "StudyPage", component: StudyPage},
    {  path: "/admin", name: "Admin", component: Admin},
    //addition in here
]

const router = createRouter({
    history: createWebHistory(),
    routes
});


export default router;
