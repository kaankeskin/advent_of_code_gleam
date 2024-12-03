import {ReadInputFile} from '../utils';

export async function solutionDay3Part1(inputFileInstance: ReadInputFile) {
  // const data = await inputFileInstance.readExampleFile();
  const data = await inputFileInstance.readInputFile();

  const regex = /mul\((\d{1,3}),\s*(\d{1,3})\)/g;

  let match;
  let result = 0;

  while ((match = regex.exec(data)) !== null) {
    const xValue = parseInt(match[1]);
    const yValue = parseInt(match[2]);

    console.log(`Found match: ${match[0]} with X: ${xValue} Y: ${yValue}`);

    const multiply = xValue * yValue;
    result += multiply;

    console.log(`Multiply result: ${multiply}. Result: ${result}\n`);
  }
}
