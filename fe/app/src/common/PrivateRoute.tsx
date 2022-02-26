import React from 'react'
import { useKeycloak } from '@react-keycloak/web'
import { Navigate } from "react-router-dom";

interface Props {
  component: React.ComponentType
  path?: string
  
}
const PrivateRoute : React.FC<Props> = ({ component: RouteComponent }) =>{
  
  const { keycloak } = useKeycloak();
  if(keycloak?.authenticated)  
 { return <RouteComponent /> ;}
  else {return <Navigate to="/" />;}
 };

export default PrivateRoute