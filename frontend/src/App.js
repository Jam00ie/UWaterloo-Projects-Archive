import './App.css';
import ProfessorsList from './components/ProfessorsList';
import CoursesList from './components/CoursesList';

function App(props) {
  return (
    <>
      <body>
        <h1>{props.name}</h1>
        <div></div>
        <h2>
        <ProfessorsList />
        <CoursesList />
        </h2>
      </body>
    </>
  );
}

export default App;