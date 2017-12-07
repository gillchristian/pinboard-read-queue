import styled from 'styled-components'

const spacing = p => (p.small ? '2px 4px' : '5px 8px')

export default styled.button`
  margin: ${spacing};
  padding: ${spacing};

  border: 1px solid gray;
  border-radius: 3px;

  background-color: white;

  cursor: pointer;
`
