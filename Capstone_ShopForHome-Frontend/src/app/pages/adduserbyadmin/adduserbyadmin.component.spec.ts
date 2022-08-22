import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AdduserbyadminComponent } from './adduserbyadmin.component';

describe('AdduserbyadminComponent', () => {
  let component: AdduserbyadminComponent;
  let fixture: ComponentFixture<AdduserbyadminComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AdduserbyadminComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdduserbyadminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
