import './App.css';
import ProfessorsList from './components/ProfessorsList';
import CoursesList from './components/CoursesList';

function App(props) {
  return (
    <>
      <h1>Hello, {props.name}</h1>
      <ProfessorsList />
      <CoursesList />
    </>
  );
}

export default App;