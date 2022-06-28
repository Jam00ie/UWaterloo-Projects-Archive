import './App.css';
import ProfessorsList from './components/ProfessorsList';

function App(props) {
  return (
    <>
      <h1>Hello, {props.name}</h1>
      <ProfessorsList />
    </>
  );
}

export default App;